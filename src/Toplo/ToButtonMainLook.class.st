Class {
	#name : #ToButtonMainLook,
	#superclass : #ToButtonLook,
	#instVars : [
		'borderBuilder'
	],
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #private }
ToButtonMainLook >> borderBuilderFromElement: anElement [

	^ borderBuilder ifNil: [
		  borderBuilder := BlBorderBuilder new
			                   paint: anElement toTheme colorBorder;
			                   width:  anElement toTheme lineWidth;
			                   lineCap: BlStrokeLineCap butt;
			                   lineJoin: BlStrokeLineJoin miter;
			                   miterLimit: 4.0;
			                   dashOffset: 0 ]
]

{ #category : #'event handling' }
ToButtonMainLook >> installLookEvent: anEvent [

	anEvent elementDo: [ :e |
		e geometry: (BlRoundedRectangleGeometry cornerRadius: e toTheme borderRadius).
		e padding: (BlInsets
				 top: e toTheme paddingXS / 2
				 left: e toTheme paddingContentHorizontal
				 bottom: e toTheme paddingXS / 2
				 right: e toTheme paddingContentHorizontal) ]
]

{ #category : #private }
ToButtonMainLook >> isMain [ 

	^ true
]
