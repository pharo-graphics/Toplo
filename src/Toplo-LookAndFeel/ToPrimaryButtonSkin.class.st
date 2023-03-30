Class {
	#name : #ToPrimaryButtonSkin,
	#superclass : #ToAbstractButtonSkin,
	#category : #'Toplo-LookAndFeel-Skins'
}

{ #category : #built }
ToPrimaryButtonSkin >> builtBackground [

	^ self theme colorPrimary 
]

{ #category : #built }
ToPrimaryButtonSkin >> builtBorderStyle [

	^ BlStrokeStyle new"
		lineCap: self lineCap;
		lineJoin: self lineJoin;
		miterLimit: self miterLimit;
		dashArray: self dashArray;
		dashOffset: self dashOffset"
]
