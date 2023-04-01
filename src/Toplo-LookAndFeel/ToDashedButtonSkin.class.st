"
Dashed button: used for adding action commonly.
"
Class {
	#name : #ToDashedButtonSkin,
	#superclass : #ToAbstractButtonSkin,
	#category : #'Toplo-LookAndFeel-Skins - Buttons'
}

{ #category : #testing }
ToDashedButtonSkin class >> type [

	^ #dashed
]

{ #category : #built }
ToDashedButtonSkin >> builtBackground [

	^ self theme colorPrimary 
]

{ #category : #built }
ToDashedButtonSkin >> builtBorderStyle [

	^ BlStrokeStyle new"
		lineCap: self lineCap;
		lineJoin: self lineJoin;
		miterLimit: self miterLimit;
		dashArray: self dashArray;
		dashOffset: self dashOffset"
]
