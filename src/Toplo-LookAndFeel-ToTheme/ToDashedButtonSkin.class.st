"
Dashed button: used for adding action commonly.
"
Class {
	#name : #ToDashedButtonSkin,
	#superclass : #ToAbstractButtonSkin,
	#category : #'Toplo-LookAndFeel-ToTheme-Skins - Buttons'
}

{ #category : #testing }
ToDashedButtonSkin class >> type [

	^ #dashed
]

{ #category : #built }
ToDashedButtonSkin >> builtBackground [

	^ self theme colorBgContainer
]

{ #category : #built }
ToDashedButtonSkin >> builtBorderBuilder [

	| builder |
	builder := super builtBorderBuilder.
	builder dashArray: #( 6 4.2 ).
	^ builder
]
