Class {
	#name : #ToListElementDresser,
	#superclass : #ToDresser,
	#instVars : [
		'keyboardHandler',
		'menuPopupHandler',
		'menuCloseHandler'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #'context menu popup' }
ToListElementDresser >> addSecondarySelectionDecorationOnNode: aChildNode In: anElement [
	" update selection decoration to show the secondary selection on which the popup is opened"

	| d |
	d := ToListSecondarySelectionElement new
		     listElement: anElement;
		     nodes: (Array with: aChildNode);
		     yourself.
	anElement addChild: d.
	menuCloseHandler := BlEventHandler
		                    on: ToContextMenuClosedEvent
		                    do: [ :event |
			                    anElement removeChild: d.
			                    anElement infinite removeEventHandler: menuCloseHandler.
			                    anElement secondarySelection deselectAll ].
	anElement infinite addEventHandler: menuCloseHandler
]

{ #category : #initialization }
ToListElementDresser >> defaultBackground [

	^ BlBackground paint: Color white
]

{ #category : #initialization }
ToListElementDresser >> defaultMargin [

	^ BlInsets all: 0
]

{ #category : #initialization }
ToListElementDresser >> defaultPadding [

	" Must be 1 to see the focus frame AND to draw selection decoration correctly (not outside infinite bounds)  "
	^ BlInsets all: 1

]

{ #category : #'api - install/uninstall  hook' }
ToListElementDresser >> installEventListenersIn: anElement [

	keyboardHandler := BlEventHandler on: BlKeyboardEvent do: [ :event | anElement infinite dispatchEvent: event ].
	menuPopupHandler := BlEventHandler on: ToContextMenuOpenedEvent do: [ :event | self popupOpenedEvent: event in: anElement ].

	anElement addEventHandler: keyboardHandler.
	anElement infinite addEventHandler: menuPopupHandler
	
	
]

{ #category : #'api - install/uninstall  hook' }
ToListElementDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement background: self defaultBackground.
	anElement margin: self defaultMargin.
	anElement padding: self defaultPadding
]

{ #category : #'api - install/uninstall  hook' }
ToListElementDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]

{ #category : #'context menu popup' }
ToListElementDresser >> popupOpenedEvent: anEvent in: anElement [

	| pos targetChildren childNode |
	pos := anElement infinite globalPointToLocal: anEvent sourceEvent position.
	targetChildren := (anElement infinite withAllChildrenAt: pos) allButLast.
	targetChildren ifEmpty: [ ^ self ].
	childNode := targetChildren last.
	childNode holder isSelected
		ifTrue: [ 
			self updatePrimarySelectionDecorationIn: anElement.
			anElement secondarySelection selectIndexes: anElement primarySelectionIndexes. ]
		ifFalse: [
			self
				addSecondarySelectionDecorationOnNode: childNode
				In: anElement.
			anElement secondarySelection selectIndex: childNode holder position ]
]

{ #category : #'api - install/uninstall  hook' }
ToListElementDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: keyboardHandler.
	anElement infinite removeEventHandler: menuPopupHandler

]

{ #category : #'context menu popup' }
ToListElementDresser >> updatePrimarySelectionDecorationIn: anElement [
	" if the node selected with right mouse click is already selected, 
	then all selected nodes are also within the secondary selection "

	anElement primarySelectionDecorations do: [ :d | d beWithSecondarySelection ].
	menuCloseHandler := BlEventHandler
		                    on: ToContextMenuClosedEvent
		                    do: [ :event |
			                    anElement primarySelectionDecorations do: [ :d |
				                    d beWithoutSecondarySelection ].
			                    anElement infinite removeEventHandler: menuCloseHandler.
			                    anElement secondarySelection deselectAll ].
	anElement infinite addEventHandler: menuCloseHandler
]
