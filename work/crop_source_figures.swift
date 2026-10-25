import AppKit
import Foundation
let root = "/private/tmp/uhc_source_render"
let out = "/Users/wz192/Documents/Codex/2026-10-24/npx-y-skills-latest-add-ningzimu/outputs/S3-HF-UHC-GLOH520_webppt/work"
let crops:[(Int,String,Double,Double,Double,Double)] = [
 (7,"uhc-poverty-cube",0.035,0.265,0.56,0.59),
 (17,"bhutan-financing-flow",0.395,0.01,0.595,0.975),
 (23,"oop-income-chart",0.255,0.015,0.73,0.95),
 (24,"government-oop-chart",0.285,0.04,0.69,0.92),
 (25,"pooled-spending-uhc-chart",0.235,0.275,0.445,0.53),
 (28,"fiscal-space-framework",0.245,0.12,0.60,0.79)
]
for (page,name,rx,ry,rw,rh) in crops {
  let path=String(format:"%@/slide-%02d.jpg",root,page)
  guard let source=NSImage(contentsOfFile:path), let cg=source.cgImage(forProposedRect:nil,context:nil,hints:nil) else { fatalError("cannot read \(path)") }
  let w=CGFloat(cg.width), h=CGFloat(cg.height)
  let rect=CGRect(x:rx*Double(w),y:ry*Double(h),width:rw*Double(w),height:rh*Double(h)).integral
  guard let cropped=cg.cropping(to:rect) else { fatalError("crop \(name)") }
  let rep=NSBitmapImageRep(cgImage:cropped)
  let data=rep.representation(using:.jpeg,properties:[.compressionFactor:0.91])!
  try data.write(to:URL(fileURLWithPath:"\(out)/\(name).jpg"))
}
