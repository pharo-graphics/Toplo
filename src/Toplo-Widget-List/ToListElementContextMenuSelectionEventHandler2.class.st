Class {
	#name : #ToListElementContextMenuSelectionEventHandler2,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Context-menu'
}

{ #category : #'selection managing' }
ToListElementContextMenuSelectionEventHandler2 >> addContextMenuSelectionIn: aListElement onNode: aChildNode [
	" update selection decoration to show the secondary selection on which the popup is opened"

	| deco |
	deco := self secondarySelectionElementClass new
		        listElement: aListElement;
		        nodes: (Array with: aChildNode);
		        yourself.
	aListElement addChild: deco
]

{ #category : #'element handlers' }
ToListElementContextMenuSelectionEventHandler2 >> contextMenuClosedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target dispatchEvent:
		(ToListElementContextMenuSelectionChangedEvent new
			 selectionModel: ToSelectionModel new;
			 sourceEvent: anEvent;
			 yourself).
	target enableScrolledEvent
]

{ #category : #'selection managing' }
ToListElementContextMenuSelectionEventHandler2 >> contextMenuSelectionOverPrimaryIn: aListElement [

	aListElement selectionElements do: [ :d |
		| deco |
		deco := self secondarySelectionElementClass new
			        listElement: aListElement;
			        nodes: d nodes;
			        yourself.
		aListElement addChild: deco ]
]

{ #category : #'api - accessing' }
ToListElementContextMenuSelectionEventHandler2 >> eventsToHandle [

	^ {
		  ToListSelectionChangedEvent.
		  ToListElementContextMenuRequest.
		  ToContextMenuClosedEvent.
		  ToListElementContextMenuSelectionChangedEvent }
]

{ #category : #'element handlers' }
ToListElementContextMenuSelectionEventHandler2 >> listElementContextMenuRequest: anEvent [

	| pos foundChildren targetChildren childNode target infinite |
	target := anEvent currentTarget.
	infinite := target infinite.
	target disableScrolledEvent.

	pos := infinite globalPointToLocal: anEvent sourceEvent position.
	foundChildren := infinite withAllChildrenAt: pos.
	foundChildren ifEmpty: [ ^ self ].
	targetChildren := foundChildren allButLast.
	targetChildren ifEmpty: [ ^ self ].
	childNode := targetChildren last.

	childNode holder isSelected
		ifTrue: [ anEvent selectionModel: target selectionModel ]
		ifFalse: [
			anEvent selectionModel: ToSelectionModel new.
			anEvent selectionModel newOperator
				selectIndex: childNode holder position;
				applyOn: anEvent selectionModel newUpdater ].

	target dispatchEvent:
		(ToListElementContextMenuSelectionChangedEvent new
			 selectionModel: anEvent selectionModel;
			 sourceEvent: anEvent sourceEvent;
			 yourself)
]

{ #category : #'element handlers' }
ToListElementContextMenuSelectionEventHandler2 >> listElementContextMenuSelectionChangedEvent: anEvent [

	| target pos targetChildren childNode |
	target := anEvent currentTarget.
	anEvent selectionModel ifEmpty: [
		self removeContextMenuSelectionIn: target.
		^ self ].
	pos := anEvent sourceEvent localPosition.
	targetChildren := (target infinite withAllChildrenAt: pos) allButLast.
	targetChildren ifEmpty: [ ^ self ].
	childNode := targetChildren last.
	childNode holder isSelected
		ifTrue: [ self contextMenuSelectionOverPrimaryIn: target ]
		ifFalse: [ self addContextMenuSelectionIn: target onNode: childNode ]
]

{ #category : #'element handlers' }
ToListElementContextMenuSelectionEventHandler2 >> listSelectionChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target currentContextMenu ifNotNil: [ :win |
		win isOpened ifTrue: [ win close ] ].
	self removeContextMenuSelectionIn: target
]

{ #category : #'selection managing' }
ToListElementContextMenuSelectionEventHandler2 >> removeContextMenuSelectionIn: aListElement [

	(aListElement allChildrenBreadthFirstSelect: [ :child |
		 child isKindOf: ToListContextMenuSelectionElement ]) do: [ :d |
		d removeFromParent ]
]

{ #category : #accessing }
ToListElementContextMenuSelectionEventHandler2 >> secondarySelectionElementClass [

	^ ToListContextMenuSelectionElement
]
