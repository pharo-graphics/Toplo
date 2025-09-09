Class {
	#name : #ToInlineMenuStarter,
	#superclass : #ToWindowStarter,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #testing }
ToInlineMenuStarter >> isForInlineWindow [

	^ true
]

{ #category : #'starting-stopping' }
ToInlineMenuStarter >> startWindow: aWindow fromManager: aManager [

	" an inline window works correctly only with wrapping (need for the flow layout)"
	aWindow itemBar isFlowable: true.
	aManager anchorElement menuBarOwner
		addItem: aWindow
		afterIndex: aManager anchorElement positionInList.
	" need to install a new skin to change the icon (from closed to opened) "
	aManager anchorElement requestNewSkin
]

{ #category : #'starting-stopping' }
ToInlineMenuStarter >> stopWindow: aWindow fromManager: aManager [

	aManager anchorElement menuBarOwner removeItem: aWindow.
	" need to install a new skin to change the icon (from closed to opened) "
	aManager anchorElement requestNewSkin
]

{ #category : #accessing }
ToInlineMenuStarter >> windowClassFromManager: aManager [

	^ aManager inlineWindowClass 
]
