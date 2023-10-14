Class {
	#name : 'ToListElement',
	#superclass : 'ToPane',
	#traits : 'TToListElementDecorator',
	#classTraits : 'TToListElementDecorator classTrait',
	#instVars : [
		'decorations',
		'dataFilter'
	],
	#category : 'Toplo-Widget-List-core',
	#package : 'Toplo-Widget-List',
	#tag : 'core'
}

{ #category : 'private - selection decoration managing' }
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

{ #category : 'private - selection decoration managing' }
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

{ #category : 'private - selection decoration managing' }
ToListElement >> blurEvent: anEvent [

	decorations do: [ :d | d blurEvent: anEvent ]
]

{ #category : 'accessing' }
ToListElement >> dataFilter [

	^ dataFilter
]

{ #category : 'accessing' }
ToListElement >> dataFilter: aDataFilter [

	dataFilter = aDataFilter ifTrue: [ ^ self ].
	dataFilter ifNotNil: [ dataFilter onUninstalledIn: self ].
	dataFilter := aDataFilter.
	dataFilter ifNotNil: [ dataFilter onInstalledIn: self ]
]

{ #category : 'accessing' }
ToListElement >> decorations [ 

	^ decorations
]

{ #category : 'initialization' }
ToListElement >> defaultBackground [

	^ BlBackground paint: Color white
]

{ #category : 'initialization' }
ToListElement >> defaultEventHandler [

	^ ToListElementEventHandler new
]

{ #category : 'initialization' }
ToListElement >> defaultLayout [

	^ BlFrameLayout new
]

{ #category : 'initialization' }
ToListElement >> defaultMargin [

	^ BlInsets all: 0
]

{ #category : 'initialization' }
ToListElement >> defaultPadding [

	" Must be 1 to see the focus frame AND to draw selection decoration correctly (not outside infinite bounds)  "
	^ BlInsets all: 1

]

{ #category : 'private - selection decoration managing' }
ToListElement >> focusEvent: anEvent [

	decorations do: [ :d | d focusEvent: anEvent ]
]

{ #category : 'initialization' }
ToListElement >> initialize [ 

	
	| localHandler |
	super initialize.
	decorations := #().
	
	localHandler := self defaultEventHandler.
	self addEventHandler: localHandler.

	self layout: self defaultLayout.
	self next: ToListInfiniteElement new.
	self next addEventHandler: (BlEventForwarder forwardTo: localHandler from: self).
	self dataSource addEventHandler: (BlEventForwarder forwardTo: localHandler from: self).
	self data addEventHandler: (BlEventForwarder forwardTo: localHandler from: self).
	
	self addChild: self next.
	self next elevation: (BlRelativeElevation elevation: SmallInteger maxVal).

	self matchParent.
	self background: self defaultBackground.
	self margin: self defaultMargin.
	self padding: self defaultPadding.

]

{ #category : 'private - selection decoration managing' }
ToListElement >> newPrimarySelectionDecorations [
	" return a collection with instances of ListSelectionDecorationElement "

	^ (self adjacentSelectedNodesGroups) collect: [ :g |
		  ToListPrimarySelectionElement new
			  listElement: self;
			  nodes: g;
			  yourself ]
]

{ #category : 'private - selection decoration managing' }
ToListElement >> removeSecondarySelectionDecoration [

	decorations do: [ :d | d hideSecondarySelection ]
]

{ #category : 'private - selection decoration managing' }
ToListElement >> secondarySelectionOverPrimary [

	decorations do: [ :d | d showSecondarySelection ]
]

{ #category : 'private - selection decoration managing' }
ToListElement >> selectionIncludesNode: aNode [

	^ aNode holder isSelected
]

{ #category : 'private - selection decoration managing' }
ToListElement >> updatePrimarySelectionDecorations [
	"add a ListDecorationElement for each group of adjacent selected nodes "

	decorations do: [ :d | d removeFromParent ].
	decorations := self newPrimarySelectionDecorations.
	self addChildren: decorations
]
