Class {
	#name : #ToTextPaneResizeHandle,
	#superclass : #ToHandle,
	#category : #'Toplo-Layout-Support-Handles'
}

{ #category : #configuration }
ToTextPaneResizeHandle >> applyConfiguration [

	super applyConfiguration.
	self extent: self thickness asPoint.
	self constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors removeAll.
			c anchors add:
				(c anchors bottomRightAnchor on: gripTarget bottomRightAnchor) ]
]

{ #category : #initialization }
ToTextPaneResizeHandle >> defaultThickness [

	^ 15
]

{ #category : #'mouse processing' }
ToTextPaneResizeHandle >> dragBy: deltaFromInitialPosition [

	gripTarget height: initialExtent y + deltaFromInitialPosition y
]

{ #category : #accessing }
ToTextPaneResizeHandle >> handleCursor [

	^ Cursor resizeBottom
]

{ #category : #skin }
ToTextPaneResizeHandle >> newRawSkin [

	^ ToScriptableSkin new
		  onInstallSkinEvent: [ :e :evt |
				  e addChild: (ToTextResizeBottomRightIcon new
							   matchParent;
							   yourself) ];
		  onHoveredSkinEvent: [ :e :evt | e mouseCursor: e handleCursor ];
		  onLeftSkinEvent: [ :e :evt | e mouseCursor: Cursor normal ];
		  yourself
]
