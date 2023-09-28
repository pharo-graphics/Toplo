Class {
	#name : #ToListElement,
	#superclass : #ToPane,
	#traits : 'TToListElementDecorator',
	#classTraits : 'TToListElementDecorator classTrait',
	#instVars : [
		'menuCloseHandler'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #'private-initialization' }
ToListElement >> addSecondarySelectionDecorationOnNode: aChildNode [
	" update selection decoration to show the secondary selection on which the popup is opened"

	| d |
	d := ToListSecondarySelectionElement new
		     listElement: self;
		     nodes: (Array with: aChildNode);
		     yourself.
	self addChild: d.
	menuCloseHandler := BlEventHandler
		                    on: ToContextMenuClosedEvent
		                    do: [ :event |
			                    self removeChild: d.
			                    self infinite removeEventHandler: menuCloseHandler.
			                    self secondarySelection deselectAll ].
	self infinite addEventHandler: menuCloseHandler
]

{ #category : #'private-initialization' }
ToListElement >> checkEmptinessChange [

	self data ifEmpty: [ ^ self showPlaceholder ].
	self hidePlaceholder
]

{ #category : #initialization }
ToListElement >> defaultBackground [

	^ BlBackground paint: Color white
]

{ #category : #initialization }
ToListElement >> defaultLayout [

	^ BlFrameLayout new
]

{ #category : #initialization }
ToListElement >> defaultMargin [

	^ BlInsets all: 0
]

{ #category : #initialization }
ToListElement >> defaultPadding [

	" Must be 1 to see the focus frame AND to draw selection decoration correctly (not outside infinite bounds)  "
	^ BlInsets all: 1

]

{ #category : #initialization }
ToListElement >> initialize [ 

	super initialize.
	self layout: self defaultLayout.
	self next elevation: (BlRelativeElevation elevation: SmallInteger maxVal).
	self matchParent.
	self withSelectionDecoration.
	self background: self defaultBackground.
	self margin: self defaultMargin.
	self padding: self defaultPadding.
	self when: BlKeyboardEvent do: [ :event | self infinite dispatchEvent: event ].
	self infinite when: ToContextMenuOpenedEvent do: [ :event | self popupOpenedEvent: event ].
	self infinite dataSource when: ToListDataEmptinessChangeEvent do: [ :event | self checkEmptinessChange ].
]

{ #category : #'private-initialization' }
ToListElement >> popupOpenedEvent: anEvent [

	| pos targetChildren childNode |
	pos := self infinite globalPointToLocal: anEvent sourceEvent position.
	targetChildren := (self infinite withAllChildrenAt: pos) allButLast.
	targetChildren ifEmpty: [ ^ self ].
	childNode := targetChildren last.
	childNode holder isSelected
		ifTrue: [ 
			self dispatchEvent: ToListSecondarySelectionAddedEvent new.
			self updatePrimarySelectionDecoration.
			self secondarySelection selectIndexes: self primarySelectionIndexes. ]
		ifFalse: [
			self
				addSecondarySelectionDecorationOnNode: childNode.
			self secondarySelection selectIndex: childNode holder position ]
]

{ #category : #'t - initialization dresser' }
ToListElement >> preInitializeDresser [ 

	super preInitializeDresser.

	self next: ToListInfiniteElement new.
	self addChild: self next
]

{ #category : #'private-initialization' }
ToListElement >> updatePrimarySelectionDecoration [
	" if the node selected with right mouse click is already selected, 
	then all selected nodes are also within the secondary selection "

	menuCloseHandler := BlEventHandler
		                    on: ToContextMenuClosedEvent
		                    do: [ :event |
			                    self dispatchEvent: (ToListSecondarySelectionRemovedEvent new).
			                    self infinite removeEventHandler: menuCloseHandler.
			                    self secondarySelection deselectAll ].
	self infinite addEventHandler: menuCloseHandler
]

{ #category : #initialization }
ToListElement >> withSelectionDecoration [

	self withSelectionDecorationUpdater: ToListPrimarySelectionUpdater new
]

{ #category : #'private-initialization' }
ToListElement >> withSelectionDecorationFactory: aValuable [

	self withSelectionDecorationUpdater: (ToListPrimarySelectionUpdater new decorationFactory: aValuable)
]

{ #category : #'private-initialization' }
ToListElement >> withSelectionDecorationUpdater: aSelectionUpdater [

	self dispatchEvent: ToListSelectionUpdaterStopEvent new.
	aSelectionUpdater onInstalledIn: self
]

{ #category : #initialization }
ToListElement >> withSelectionDresserFactory: aValuable [
	"aValuable value is a a dresser instance that can be an instance of a subclass of ToListSelectionDresser. "

	self withSelectionDecorationFactory: [ ToListSelectionElement new dresser: aValuable value ]
]

{ #category : #initialization }
ToListElement >> withoutSelectionDecoration [

	self dispatchEvent: ToListSelectionUpdaterStopEvent new
]
