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

	^ ToNoCustomPlacement new
]

{ #category : #accessing }
ToEdgePaneManager >> defaultWindowClass [

	^ ToEdgePane 
]

{ #category : #'api - hooks' }
ToEdgePaneManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	overlay := ToOverlayElement new.
	overlay background: (Color lightGray alpha: 0.3)
]

{ #category : #'api - hooks' }
ToEdgePaneManager >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	overlay := nil
]

{ #category : #'window handling' }
ToEdgePaneManager >> onWindowClosedOnEvent: anEvent [

	overlay detachFromParent.
	super onWindowClosedOnEvent: anEvent
]

{ #category : #'window handling' }
ToEdgePaneManager >> onWindowOpenedOnEvent: anEvent [

	super onWindowOpenedOnEvent: anEvent.
	overlay attachToParent: self anchorRoot.

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
