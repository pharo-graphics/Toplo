Class {
	#name : #ToTextPaneResizeGrip,
	#superclass : #ToResizeGrip,
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #initialization }
ToTextPaneResizeGrip >> attachTo: anElement [

	super attachTo: anElement.
	self extent: self thickness asPoint.
	self constraintsDo: [ :c |
			c anchors add:
				(c anchors bottomRightAnchor on: anElement bottomRightAnchor) ]
]

{ #category : #initialization }
ToTextPaneResizeGrip >> defaultThickness [

	^ 15
]

{ #category : #'mouse processing' }
ToTextPaneResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement height: initialExtent y + deltaFromInitialPosition y
]

{ #category : #skin }
ToTextPaneResizeGrip >> newRawSkin [

	^ ToScriptableSkin new
		  onInstallSkinEvent: [ :e :evt |
				  e addChild: (ToTextResizeBottomRightIcon new
							   matchParent;
							   yourself) ];
		  onHoveredSkinEvent: [ :e :evt | e mouseCursor: e resizeCursor ];
		  onLeftSkinEvent: [ :e :evt | e mouseCursor: Cursor normal ];
		  yourself
]

{ #category : #accessing }
ToTextPaneResizeGrip >> resizeCursor [

	^ Cursor resizeBottom
]
