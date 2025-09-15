Class {
	#name : #ToEdgePaneManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'overlay'
	],
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #initialization }
ToEdgePaneManager >> defaultPlacement [ 

	^ ToAnchoredTopLeftDownPlacement new
]

{ #category : #accessing }
ToEdgePaneManager >> defaultWindowClass [

	^ ToEdgePane 
]

{ #category : #'window handling' }
ToEdgePaneManager >> onWindowClosedOnEvent: anEvent [

	super onWindowClosedOnEvent: anEvent.
	overlay detachFromParent.
	overlay := nil
]

{ #category : #'window handling' }
ToEdgePaneManager >> onWindowOpenedOnEvent: anEvent [

	super onWindowOpenedOnEvent: anEvent.
	overlay := ToOverlayElement new.
	overlay background: (Color lightGray alpha: 0.3).
	overlay attachToParent: self anchorRoot
]

{ #category : #'window handling' }
ToEdgePaneManager >> requestCloseWindowOnEvent: anEvent [
	" don't autoclose if mouse up on a filter textfield "

	| target |
	target := anEvent target.
	currentWindow ifNotNil: [
		(target withAllParentsInclude: currentWindow) ifTrue: [ ^ self ] ].
	super requestCloseWindowOnEvent: anEvent
]
