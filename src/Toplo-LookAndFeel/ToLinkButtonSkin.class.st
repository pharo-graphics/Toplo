"
Link button: used for external links.
"
Class {
	#name : #ToLinkButtonSkin,
	#superclass : #ToAbstractButtonSkin,
	#category : #'Toplo-LookAndFeel-Skins - Buttons'
}

{ #category : #accessing }
ToLinkButtonSkin class >> type [

	^ #link
]

{ #category : #built }
ToLinkButtonSkin >> builtBackground [

	^ self theme colorPrimary 
]

{ #category : #built }
ToLinkButtonSkin >> builtBorderStyle [

	^ BlStrokeStyle new"
		lineCap: self lineCap;
		lineJoin: self lineJoin;
		miterLimit: self miterLimit;
		dashArray: self dashArray;
		dashOffset: self dashOffset"
]
