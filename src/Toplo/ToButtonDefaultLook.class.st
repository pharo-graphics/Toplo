Class {
	#name : #ToButtonDefaultLook,
	#superclass : #ToButtonLook,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #private }
ToButtonDefaultLook >> borderBuilderFromElement: anElement [

	^ BlBorderBuilder new
		  paint: anElement toTheme colorBorder;
		  width: anElement toTheme lineWidth;
		  lineCap: BlStrokeLineCap butt;
		  lineJoin: BlStrokeLineJoin miter;
		  miterLimit: 4.0;
		  dashOffset: 0
]

{ #category : #testing }
ToButtonDefaultLook >> hasBackground [

	^ true
]

{ #category : #'event handling' }
ToButtonDefaultLook >> hoverStateEvent: anEvent [

	anEvent elementDo: [ :e |
		e border: ((self decoratedBorderBuilderFromElement: e)
				 paint: e toTheme colorPrimaryHover;
				 build) ]
]

{ #category : #'event handling' }
ToButtonDefaultLook >> initialStateEvent: anEvent [

	anEvent elementDo: [ :e |
		e border: (self decoratedBorderBuilderFromElement: e) build.
		e privateSkin hasBackground ifTrue: [ 
			e background: e toTheme colorBgContainer ] ]
]

{ #category : #'event handling' }
ToButtonDefaultLook >> installStateEvent: anEvent [

	anEvent elementDo: [ :e |
		e border: (self decoratedBorderBuilderFromElement: e) build.
		e privateSkin hasBackground ifTrue: [ 
			e background: e toTheme colorBgContainer ].
		e geometry: (BlRoundedRectangleGeometry cornerRadius: e toTheme borderRadius).
		e padding: (BlInsets
				 top: e toTheme paddingXS / 2
				 left: e toTheme paddingContentHorizontal
				 bottom: e toTheme paddingXS / 2
				 right: e toTheme paddingContentHorizontal).
		e effect: (BlGaussianShadowEffect
				 color: (e toTheme colorBorder
					  alphaMixed: 0.233
					  with: e toTheme backgroundColor)
				 width: 2
				 offset: 0 @ 2)]
]

{ #category : #'event handling' }
ToButtonDefaultLook >> pressedStateEvent: anEvent [

	anEvent elementDo: [ :e |
		e border:
			((self decoratedBorderBuilderFromElement: e) paint:
				 e toTheme colorPrimaryPressed) build ]
]
