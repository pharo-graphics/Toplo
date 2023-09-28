Class {
	#name : #ToListElement,
	#superclass : #ToPane,
	#traits : 'TToListElementDecorator',
	#classTraits : 'TToListElementDecorator classTrait',
	#instVars : [
		'decorations',
		'popupMenuCloseHandler'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #'private - selection decoration managing' }
ToListElement >> addSecondarySelectionDecorationOnNode: aChildNode [
	" update selection decoration to show the secondary selection on which the popup is opened"

	| deco |
	deco := ToListSecondarySelectionElement new
		        listElement: self;
		        nodes: (Array with: aChildNode);
		        yourself.
	decorations := decorations copyWith: deco.
	self addChild: deco
]

{ #category : #'private - selection decoration managing' }
ToListElement >> adjacentSelectedNodesGroups [
	" return an array of collection. Each collection contains a list of adjacent selected nodes "

	^ Array streamContents: [ :stream |
		  | g |
		  g := OrderedCollection new.
		  self infinite childrenDo: [ :node |
			  (self selectionIncludesNode: node)
				  ifTrue: [ g add: node ]
				  ifFalse: [
					  g ifNotEmpty: [
						  stream nextPut: g.
						  g := OrderedCollection new ] ] ].
		  g ifNotEmpty: [ stream nextPut: g ] ]
]

{ #category : #'private - selection decoration managing' }
ToListElement >> blurEvent: anEvent [

	decorations do: [ :d | d blurEvent: anEvent ]
]

{ #category : #private }
ToListElement >> checkEmptinessChange [

	self data ifEmpty: [ ^ self showPlaceholder ].
	self hidePlaceholder
]

{ #category : #accessing }
ToListElement >> decorations [ 

	^ decorations
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

{ #category : #'private - selection decoration managing' }
ToListElement >> focusEvent: anEvent [

	decorations do: [ :d | d focusEvent: anEvent ]
]

{ #category : #initialization }
ToListElement >> initialize [ 

	super initialize.
	decorations := #().
	self layout: self defaultLayout.
	self next: ToListInfiniteElement new.
	self addChild: self next.
	self next elevation: (BlRelativeElevation elevation: SmallInteger maxVal).

	self infinite when: BlElementExtentChangedEvent do: [ self updatePrimarySelectionDecorations  ].
	self infinite when: BlElementScrolledEvent do: [ self updatePrimarySelectionDecorations  ].
	self infinite when: ToInfiniteSelectionChangedEvent do: [ self updatePrimarySelectionDecorations  ].
	self infinite when: BlBlurEvent do: [ :event | self blurEvent: event ].
	self infinite when: BlFocusEvent do: [ :event | self focusEvent: event ].
	self infinite when: ToContextMenuOpenedEvent do: [ :event | self popupOpenedEvent: event ].
	self infinite dataSource when: ToListDataEmptinessChangeEvent do: [ :event | self checkEmptinessChange ].
	self when: BlKeyboardEvent do: [ :event | self infinite dispatchEvent: event ].

	self matchParent.
	self withSelectionDecoration.
	self background: self defaultBackground.
	self margin: self defaultMargin.
	self padding: self defaultPadding.

]

{ #category : #'private - selection decoration managing' }
ToListElement >> newPrimarySelectionDecorations [
	" return a collection with instances of ListSelectionDecorationElement "

	^ (self adjacentSelectedNodesGroups) collect: [ :g |
		  ToListPrimarySelectionElement new
			  listElement: self;
			  nodes: g;
			  yourself ]
]

{ #category : #'private - selection decoration managing' }
ToListElement >> popupOpenedEvent: anEvent [

	| pos targetChildren childNode |
	self infinite disableScrolledEvent.
	pos := self infinite globalPointToLocal: anEvent sourceEvent position.
	targetChildren := (self infinite withAllChildrenAt: pos) allButLast.
	targetChildren ifEmpty: [ ^ self ].
	childNode := targetChildren last.
	childNode holder isSelected
		ifTrue: [ 
			self secondarySelectionOverPrimary.		
			self secondarySelection selectIndexes: self primarySelectionIndexes. ]
		ifFalse: [
			self addSecondarySelectionDecorationOnNode: childNode.
			self secondarySelection selectIndex: childNode holder position].
	self setUpPopupCloseHandler.
]

{ #category : #'private - selection decoration managing' }
ToListElement >> removeSecondarySelectionDecoration [

	decorations do: [ :d | d hideSecondarySelection ]
]

{ #category : #'private - selection decoration managing' }
ToListElement >> secondarySelectionOverPrimary [

	decorations do: [ :d | d showSecondarySelection ]
]

{ #category : #'private - selection decoration managing' }
ToListElement >> selectionIncludesNode: aNode [

	^ aNode holder isSelected
]

{ #category : #'private - selection decoration managing' }
ToListElement >> setUpPopupCloseHandler [
	" if the node selected with right mouse click is already selected, 
	then all selected nodes are also within the secondary selection "

	popupMenuCloseHandler := BlEventHandler
		                         on: ToContextMenuClosedEvent
		                         do: [
			                         self removeSecondarySelectionDecoration.
			                         self infinite removeEventHandler: popupMenuCloseHandler.
			                         self secondarySelection deselectAll.
			                         self infinite enableScrolledEvent ].
	self infinite addEventHandler: popupMenuCloseHandler
]

{ #category : #'private - selection decoration managing' }
ToListElement >> updatePrimarySelectionDecorations [
	"add a ListDecorationElement for each group of adjacent selected nodes "

	decorations do: [ :d | d removeFromParent ].
	decorations := self newPrimarySelectionDecorations.
	self addChildren: decorations
]

{ #category : #initialization }
ToListElement >> withSelectionDecoration [

	
]

{ #category : #initialization }
ToListElement >> withoutSelectionDecoration [


]
