package util;

import sys.FileSystem;
import sys.io.File;
import haxe.Json;
import haxe.io.BytesInput;
import haxe.zip.Reader;
import haxe.zip.Entry;
import haxe.zip.Uncompress;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxRect;
import flixel.math.FlxPoint;
import openfl.display.BitmapData;
import openfl.geom.Matrix;

class AnimateAtlas {
    public static function loadFromZip(path:String):FlxAtlasFrames {
        if (!FileSystem.exists(path)) {
            trace("AnimateAtlas: missing file " + path);
            return null;
        }

        var reader = new Reader(new BytesInput(File.getBytes(path)));
        var entries = [for (e in reader.read()) e];

        var dataJson:String = "";
        var libraryJson:String = "";
        var symbolPNGs:Map<String, haxe.io.Bytes> = [];

        for (entry in entries) {
            var content = Uncompress.run(entry.data); // ✅ entry.data
            if (entry.fileName.endsWith("data.json"))
                dataJson = content.toString();
            else if (entry.fileName.endsWith("library.json"))
                libraryJson = content.toString();
            else if (entry.fileName.startsWith("symbols/") && entry.fileName.endsWith(".png"))
                symbolPNGs.set(entry.fileName, content);
        }

        if (dataJson == "" || libraryJson == "") {
            trace("AnimateAtlas: zip missing JSONs");
            return null;
        }

        var data:Array<Dynamic> = Json.parse(dataJson);
        var library:Dynamic = Json.parse(libraryJson);

        return buildFrames(data, library, symbolPNGs);
    }

    static function buildFrames(data:Array<Dynamic>, library:Dynamic, symbolPNGs:Map<String, haxe.io.Bytes>):FlxAtlasFrames {
        var frames = new FlxAtlasFrames(null, null);

        for (entry in data) {
            if (entry.type == 5 && entry.className != null && entry.frames != null) {
                var animName:String = entry.className;
                var frameIndex:Int = 0;

                for (fr in (entry.frames : Array<Dynamic>)) {
                    var bmp = new BitmapData(1, 1, true, 0x0);
                    var objects:Array<Dynamic> = fr.objects;

                    var parts:Array<{bmp:BitmapData, mat:Array<Float>}> = [];
                    var minX:Float = 99999;
                    var minY:Float = 99999;
                    var maxX:Float = -99999;
                    var maxY:Float = -99999;

                    for (obj in (objects : Array<Dynamic>)) {
                        var sid:Int = obj.symbol;
                        var mat:Array<Float> = obj.matrix;
                        if (mat == null || mat.length != 6) mat = [1,0,0,1,0,0];

                        var path:String = null;
                        for (s in (library.symbols : Array<Dynamic>)) {
                            if (s.id == sid && s.path != null) {
                                path = s.path;
                                break;
                            }
                        }

                        if (path != null && symbolPNGs.exists(path)) {
                            var bytes = symbolPNGs.get(path);
                            var symbolBmp = BitmapData.fromBytes(bytes);

                            var w = symbolBmp.width;
                            var h = symbolBmp.height;
                            var a = mat[0], b = mat[1], c = mat[2], d = mat[3], tx = mat[4], ty = mat[5];

                            var pts = [
                                {x:0., y:0.}, {x:w, y:0.}, {x:0., y:h}, {x:w, y:h}
                            ];
                            for (p in pts) {
                                var X = a*p.x + c*p.y + tx;
                                var Y = b*p.x + d*p.y + ty;
                                if (X < minX) minX = X;
                                if (Y < minY) minY = Y;
                                if (X > maxX) maxX = X;
                                if (Y > maxY) maxY = Y;
                            }

                            parts.push({bmp:symbolBmp, mat:mat});
                        }
                    }

                    if (parts.length > 0) {
                        var w = Math.ceil(maxX - minX);
                        var h = Math.ceil(maxY - minY);
                        if (w <= 0) w = 1;
                        if (h <= 0) h = 1;
                        bmp = new BitmapData(w, h, true, 0x0);

                        for (p in parts) {
                            var matrix = new Matrix(p.mat[0], p.mat[1], p.mat[2], p.mat[3],
                                p.mat[4] - minX, p.mat[5] - minY);
                            bmp.draw(p.bmp, matrix);
                        }
                    }

                    // ✅ Psych 1.0.4 expects FlxRect, no FlxGraphic here
                    var rect = FlxRect.get(0, 0, bmp.width, bmp.height);

                    frames.addAtlasFrame(
                        rect,
                        FlxPoint.get(bmp.width, bmp.height),
                        FlxPoint.get(),
                        animName
                    );

                    frameIndex++;
                }
            }
        }

        return frames;
    }
}
