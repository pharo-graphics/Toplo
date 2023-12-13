Class {
	#name : 'ToListElementContextMenuSelectionEventHandler',
	#superclass : 'BlCustomEventHandler',
	#instVars : [
		'contextMenuSelection'
	],
	#category : 'Toplo-Widget-List-Context-menu',
	#package : 'Toplo-Widget-List',
	#tag : 'Context-menu'
}

{ #category : 'selection managing' }
ToListElementContextMenuSelectionEventHandler >> addContextMenuSelectionIn: aListElement onNode: aChildNode [
	" update selection decoration to show the secondary selection on which the popup is opened"

	| deco |
	deco := self secondarySelectionElementClass new
		        listElement: aListElement;
		        nodes: (Array with: aChildNode);
		        yourself.
	aListElement addChild: deco
]

{ #category : 'element handlers' }
ToListElementContextMenuSelectionEventHandler >> contextMenuClosedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	self contextMenuSelection deselectAll.
	target dispatchEvent:
		(ToListElementContextMenuSelectionChangedEvent new
			 selectedIndexes: #(  );
			 sourceEvent: anEvent;
			 yourself).
	target enableScrolledEvent
]

{ #category : 'accessing' }
ToListElementContextMenuSelectionEventHandler >> contextMenuSelection [

	^ contextMenuSelection
]

{ #category : 'selection managing' }
ToListElementContextMenuSelectionEventHandler >> contextMenuSelectionOverPrimaryIn: aListElement [

	aListElement selectionElements do: [ :d |
		| deco |
		deco := self secondarySelectionElementClass new
			        listElement: aListElement;
			        nodes: d nodes;
			        yourself.
		aListElement addChild: deco ]
]

{ #category : 'api - accessing' }
ToListElementContextMenuSelectionEventHandler >> eventsToHandle [

	^ {
		  ToListSelectionElementUpdatedEvent.
		  ToListElementContextMenuRequest.
		  ToContextMenuClosedEvent.
		  ToListElementContextMenuSelectionChangedEvent }
]

{ #category : 'initialization' }
ToListElementContextMenuSelectionEventHandler >> initialize [

	super initialize.
	contextMenuSelection := ToListSelectionModel new

]

{ #category : 'element handlers' }
ToListElementContextMenuSelectionEventHandler >> listElementContextMenuRequest: anEvent [

	| pos targetChildren childNode target infinite |
	target := anEvent currentTarget.
	infinite := target infinite.
	target disableScrolledEvent.

	pos := infinite globalPointToLocal: anEvent sourceEvent position.
	targetChildren := (infinite withAllChildrenAt: pos) allButLast.

	anEvent selectionIndexes: #(  ).

	targetChildren ifEmpty: [ ^ self ].
	childNode := targetChildren last.

	childNode holder isSelected
		ifTrue: [ self contextMenuSelection selectIndexes: target selectionIndexes ]
		ifFalse: [ self contextMenuSelection selectIndex: childNode holder position ].

	anEvent selectionIndexes: self secondarySelectionIndexes.

	target dispatchEvent:
		(ToListElementContextMenuSelectionChangedEvent new
			 selectedIndexes: self secondarySelectionIndexes;
			 sourceEvent: anEvent sourceEvent;
			 yourself)
]

{ #category : 'element handlers' }
ToListElementContextMenuSelectionEventHandler >> listElementContextMenuSelectionChangedEvent: anEvent [

	| node target pos targetChildren infinite childNode |
	target := anEvent currentTarget.
	anEvent selectedIndexes ifEmpty: [
		self removeContextMenuSelectionIn: target.
		^ self ].
	pos := target globalPointToLocal: anEvent sourceEvent position.
	targetChildren := (target infinite withAllChildrenAt: pos) allButLast.
	targetChildren ifEmpty: [ ^ self ].
	childNode := targetChildren last.
	childNode holder isSelected
		ifTrue: [ self contextMenuSelectionOverPrimaryIn: target ]
		ifFalse: [
		self addContextMenuSelectionIn: target onNode: childNode ]
]

{ #category : 'element handlers' }
ToListElementContextMenuSelectionEventHandler >> listSelectionElementUpdatedEvent: anEvent [

	anEvent currentTarget currentContextMenu ifNotNil: [ :win | win close ].
	self removeContextMenuSelectionIn: anEvent currentTarget.
]

{ #category : 'selection managing' }
ToListElementContextMenuSelectionEventHandler >> removeContextMenuSelectionIn: aListElement [

	(aListElement allChildrenBreadthFirstSelect: [ :child |
		 child isKindOf: ToListContextMenuSelectionElement ]) do: [ :d |
		d removeFromParent ]
]

{ #category : 'accessing' }
ToListElementContextMenuSelectionEventHandler >> secondarySelectionElementClass [

	^ ToListContextMenuSelectionElement
]

{ #category : 'accessing' }
ToListElementContextMenuSelectionEventHandler >> secondarySelectionIndexes [ 

	^ self contextMenuSelection selectedIndexes
]
