//
//  ViewController.swift
//  StitchedImageWGUA
//
//  Created by JNYJ on 14-11-15.
//  Copyright (c) 2014年 JNYJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		JNYJStitchedImages.shareJNYJStitchedImages();
		//
		var view_ = JNYJStitchedImages(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		view_.backgroundColor =  UIColor.redColor()
		view_.image = UIImage(named: "JNYJ")

		JNYJStitchedImages.shareJNYJStitchedImages().addSubview(view_)

		view_ = JNYJStitchedImages(frame: CGRect(x: 0, y: 300, width: 100, height: 100))
		view_.backgroundColor =  UIColor.blueColor()
		view_.image = UIImage(named: "JNYJ")

		JNYJStitchedImages.shareJNYJStitchedImages().addSubview(view_)


		//
		JNYJStitchedImages.shareJNYJStitchedImages().backgroundColor = UIColor.blueColor()
		JNYJStitchedImages.shareJNYJStitchedImages().image = UIImage(named: "JNYJ")

		JNYJStitchedImages.shareJNYJStitchedImages().frame = CGRectMake(10, 20, 300, 440);
		self.view.addSubview(JNYJStitchedImages.shareJNYJStitchedImages())

		var image_ =  JNYJStitchedImages.shareJNYJStitchedImages().stitchedImageWithSize(
			CGSize(width: 300, height: 440),
			borderOffset: 2, borderColor: UIColor.redColor())


		JNYJStitchedImages.shareJNYJStitchedImages().addSubview(UIImageView(image: image_))
	}





	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
}

