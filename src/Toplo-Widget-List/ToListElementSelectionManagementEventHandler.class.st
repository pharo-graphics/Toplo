Class {
	#name : 'ToListElementSelectionManagementEventHandler',
	#superclass : 'BlCustomEventHandler',
	#instVars : [
		'decorations',
		'secondarySelection'
	],
	#category : 'Toplo-Widget-List-core',
	#package : 'Toplo-Widget-List',
	#tag : 'core'
}

{ #category : 'selection managing' }
ToListElementSelectionManagementEventHandler >> addSecondarySelectionDecorationIn: aListElement onNode: aChildNode [
	" update selection decoration to show the secondary selection on which the popup is opened"

	| deco |
	deco := self secondarySelectionElementClass new
		        listElement: aListElement;
		        nodes: (Array with: aChildNode);
		        yourself.
	decorations := decorations copyWith: deco.
	aListElement addChild: deco
]

{ #category : 'selection managing' }
ToListElementSelectionManagementEventHandler >> adjacentSelectedNodesGroupsIn: aListElement [
	" return an array of collection. Each collection contains a list of adjacent selected nodes "

	^ Array streamContents: [ :stream |
		  | g |
		  g := OrderedCollection new.
		  aListElement infinite childrenDo: [ :node |
			  (node holder isSelected)
				  ifTrue: [ g add: node ]
				  ifFalse: [
					  g ifNotEmpty: [
						  stream nextPut: g.
						  g := OrderedCollection new ] ] ].
		  g ifNotEmpty: [ stream nextPut: g ] ]
]

{ #category : 'element handlers' }
ToListElementSelectionManagementEventHandler >> blurEvent: anEvent [

	decorations do: [ :d | d blurEvent: anEvent ]
]

{ #category : 'element handlers' }
ToListElementSelectionManagementEventHandler >> contextMenuClosedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	self secondarySelection deselectAll.
	target dispatchEvent:
		(ToListElementSecondarySelectionChangedEvent new
			 selectedIndexes: #(  );
			 sourceEvent: anEvent;
			 yourself).
	 target infinite enableScrolledEvent
]

{ #category : 'initialization' }
ToListElementSelectionManagementEventHandler >> defaultSecondarySelection [

	^ ToListSelectionModel new
]

{ #category : 'element handlers' }
ToListElementSelectionManagementEventHandler >> elementExtentChangedEvent: anEvent [

	self updatePrimarySelectionDecorationsFromEvent: anEvent
]

{ #category : 'element handlers' }
ToListElementSelectionManagementEventHandler >> elementScrolledEvent: anEvent [

	self updatePrimarySelectionDecorationsFromEvent: anEvent
]

{ #category : 'api - accessing' }
ToListElementSelectionManagementEventHandler >> eventsToHandle [

	^ {
		  BlFocusEvent.
		  BlBlurEvent.
		  BlElementExtentChangedEvent.
		  BlElementScrolledEvent.
		  ToListElementContextMenuRequest.
		  ToContextMenuClosedEvent.
		  ToListElementPrimarySelectionChangedEvent.
		  ToListElementSecondarySelectionChangedEvent }
]

{ #category : 'element handlers' }
ToListElementSelectionManagementEventHandler >> focusEvent: anEvent [

	decorations do: [ :d | d focusEvent: anEvent ]
]

{ #category : 'initialization' }
ToListElementSelectionManagementEventHandler >> initialize [

	super initialize.
	decorations := #(  ).
	secondarySelection := self defaultSecondarySelection.

]

{ #category : 'element handlers' }
ToListElementSelectionManagementEventHandler >> listElementContextMenuRequest: anEvent [

	| pos targetChildren childNode target infinite |
	target := anEvent currentTarget.
	infinite := target infinite.
	infinite disableScrolledEvent.
	
	self flag: 'have to fix it. a dbl click can be launched event with an openedContextMenu...'.
	infinite terminateClickLauncher.

	pos := infinite globalPointToLocal: anEvent sourceEvent position.
	targetChildren := (infinite withAllChildrenAt: pos) allButLast.

	anEvent secondarySelectionIndexes: #(  ).
	anEvent selectionIndexes: #(  ).

	targetChildren ifEmpty: [ ^ self ].
	childNode := targetChildren last.

	childNode holder isSelected
		ifTrue: [ self secondarySelection selectIndexes: target selectionIndexes ]
		ifFalse: [ self secondarySelection selectIndex: childNode holder position ].

	anEvent secondarySelectionIndexes: self secondarySelectionIndexes.
	anEvent selectionIndexes: target selectionIndexes.

	target dispatchEvent:
		(ToListElementSecondarySelectionChangedEvent new
			 selectedIndexes: self secondarySelectionIndexes;
			 sourceEvent: anEvent sourceEvent;
			 yourself)
]

{ #category : 'element handlers' }
ToListElementSelectionManagementEventHandler >> listElementPrimarySelectionChangedEvent: anEvent [

	self updatePrimarySelectionDecorationsFromEvent: anEvent
]

{ #category : 'element handlers' }
ToListElementSelectionManagementEventHandler >> listElementSecondarySelectionChangedEvent: anEvent [

	| node target |
	target := anEvent currentTarget.
	anEvent selectedIndexes ifEmpty: [
		self removeSecondarySelectionDecoration.
		^ self ].
	node := target nodeAt: anEvent selectedIndexes first.
	node holder isSelected
		ifTrue: [ self secondarySelectionOverPrimary ]
		ifFalse: [
		self addSecondarySelectionDecorationIn: target onNode: node ]
]

{ #category : 'selection managing' }
ToListElementSelectionManagementEventHandler >> newPrimarySelectionDecorationsFromEvent: anEvent [
	" return a collection with instances of ListSelectionDecorationElement "

	^ (self adjacentSelectedNodesGroupsIn: anEvent currentTarget ) collect: [ :g |
		  self primarySelectionElementClass new
			  listElement: anEvent currentTarget;
			  nodes: g;
			  yourself ]
]

{ #category : 'accessing' }
ToListElementSelectionManagementEventHandler >> primarySelectionElementClass [

	^ ToListPrimarySelectionElement 
]

{ #category : 'selection managing' }
ToListElementSelectionManagementEventHandler >> removeSecondarySelectionDecoration [

	decorations do: [ :d | d hideSecondarySelection ]
]

{ #category : 'accessing' }
ToListElementSelectionManagementEventHandler >> secondarySelection [

	^ secondarySelection
]

{ #category : 'accessing' }
ToListElementSelectionManagementEventHandler >> secondarySelectionElementClass [

	^ ToListSecondarySelectionElement
]

{ #category : 'accessing' }
ToListElementSelectionManagementEventHandler >> secondarySelectionIndexes [ 

	^ self secondarySelection selectedIndexes
]

{ #category : 'selection managing' }
ToListElementSelectionManagementEventHandler >> secondarySelectionOverPrimary [

	decorations do: [ :d | d showSecondarySelection ]
]

{ #category : 'selection managing' }
ToListElementSelectionManagementEventHandler >> updatePrimarySelectionDecorationsFromEvent: anEvent [
	"add a ListDecorationElement for each group of adjacent selected nodes "

	decorations do: [ :d | d removeFromParent ].
	decorations := self newPrimarySelectionDecorationsFromEvent: anEvent.
	anEvent currentTarget addChildren: decorations
]
