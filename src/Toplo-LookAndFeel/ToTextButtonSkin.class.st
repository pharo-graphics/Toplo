"
Text button: used for the most secondary action.
"
Class {
	#name : #ToTextButtonSkin,
	#superclass : #ToAbstractButtonSkin,
	#category : #'Toplo-LookAndFeel-Skins - Buttons'
}

{ #category : #accessing }
ToTextButtonSkin class >> type [

	^ #text
]

{ #category : #built }
ToTextButtonSkin >> builtBackground [

	^ self theme colorPrimary 
]

{ #category : #built }
ToTextButtonSkin >> builtBorderStyle [

	^ BlStrokeStyle new"
		lineCap: self lineCap;
		lineJoin: self lineJoin;
		miterLimit: self miterLimit;
		dashArray: self dashArray;
		dashOffset: self dashOffset"
]
