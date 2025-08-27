package util;

import sys.FileSystem;
import sys.io.File;
import haxe.Json;
import haxe.io.Bytes;
import haxe.zip.Reader;
import haxe.zip.Entry;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import openfl.geom.Matrix;

class AnimateAtlas {
    /**
     * Load an AnimateAtlas character directly from a .zip
     * Example: mods/characters/myChar.zip
     */
    public static function loadFromZip(path:String):FlxAtlasFrames {
        if (!FileSystem.exists(path)) {
            trace("AnimateAtlas: missing " + path);
            return null;
        }

        var bytes:Bytes = File.getBytes(path);
        var reader = new Reader(bytes);
        var entries:Array<Entry> = reader.read();

        var dataJson:String = "";
        var libraryJson:String = "";
        var symbolPNGs:Map<String, Bytes> = [];

        for (entry in entries) {
            if (entry.fileName.endsWith("data.json"))
                dataJson = reader.unzip(entry).toString();
            else if (entry.fileName.endsWith("library.json"))
                libraryJson = reader.unzip(entry).toString();
            else if (entry.fileName.startsWith("symbols/") && entry.fileName.endsWith(".png"))
                symbolPNGs.set(entry.fileName, reader.unzip(entry));
        }

        if (dataJson == "" || libraryJson == "") {
            trace("AnimateAtlas: missing JSONs in " + path);
            return null;
        }

        var data:Dynamic = Json.parse(dataJson);
        var library:Dynamic = Json.parse(libraryJson);

        // Build atlas frames
        return buildFrames(data, library, symbolPNGs);
    }

    /**
     * Core builder: takes parsed JSON + raw symbol PNGs → FlxAtlasFrames
     */
    static function buildFrames(data:Dynamic, library:Dynamic, symbolPNGs:Map<String, Bytes>):FlxAtlasFrames {
        var frames = new FlxAtlasFrames(null, null);
        if (data == null || data.length == 0) {
            trace("AnimateAtlas: empty data.json");
            return frames;
        }

        // Iterate through exported symbols (className = anim name)
        for (entry in data) {
            if (entry.type == 5 && entry.className != null && entry.frames != null) {
                var animName:String = entry.className;
                var frameIndex:Int = 0;

                for (fr in entry.frames) {
                    var bmp = new BitmapData(1, 1, true, 0x0);
                    var objects = fr.objects;

                    // determine bounding box
                    var minX:Float = 99999;
                    var minY:Float = 99999;
                    var maxX:Float = -99999;
                    var maxY:Float = -99999;

                    var parts:Array<{bmp:BitmapData, mat:Array<Float>}> = [];

                    for (obj in objects) {
                        var sid:Int = obj.symbol;
                        var mat:Array<Float> = obj.matrix;
                        if (mat == null || mat.length != 6) mat = [1,0,0,1,0,0];

                        // look up path from library.json
                        var path:String = null;
                        if (library != null && library.symbols != null) {
                            for (s in library.symbols) {
                                if (s.id == sid && s.path != null) {
                                    path = s.path;
                                    break;
                                }
                            }
                        }

                        if (path != null && symbolPNGs.exists(path)) {
                            var imgBytes = symbolPNGs.get(path);
                            var symbolBmp = BitmapData.fromBytes(imgBytes);

                            // transform bbox
                            var w = symbolBmp.width;
                            var h = symbolBmp.height;
                            var a = mat[0], b = mat[1], c = mat[2], d = mat[3], tx = mat[4], ty = mat[5];

                            var pts = [
                                {x:0.0, y:0.0},
                                {x:w, y:0.0},
                                {x:0.0, y:h},
                                {x:w, y:h}
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

                    var rect = new Rectangle(0, 0, bmp.width, bmp.height);
                    var frame = new FlxFrame(frames, animName + "_" + frameIndex, rect, rect);
                    frame.parent = frames;
                    frame.sourceSize.set(bmp.width, bmp.height);
                    frame.frame = rect;
                    frame.bitmap = bmp;
                    frames.addAtlasFrame(frame);

                    frameIndex++;
                }
            }
        }

        return frames;
    }
}
