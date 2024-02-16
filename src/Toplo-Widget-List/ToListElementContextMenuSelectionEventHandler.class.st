Class {
	#name : #ToListElementContextMenuSelectionEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Context-menu'
}

{ #category : #'selection managing' }
ToListElementContextMenuSelectionEventHandler >> addContextMenuSelectionIn: aListElement onNode: aChildNode [
	" update selection decoration to show the secondary selection on which the popup is opened"

	| deco |
	deco := self secondarySelectionElementClass new
		        listElement: aListElement;
		        nodes: (Array with: aChildNode);
		        yourself.
	aListElement addChild: deco
]

{ #category : #'element handlers' }
ToListElementContextMenuSelectionEventHandler >> contextMenuClosedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target dispatchEvent:
		(ToListElementContextMenuSelectionChangedEvent new
			 sourceEvent: anEvent;
			 yourself).
	target enableScrolledEvent
]

{ #category : #'selection managing' }
ToListElementContextMenuSelectionEventHandler >> contextMenuSelectionOverPrimaryIn: aListElement [

	aListElement selectionElements do: [ :d |
		| deco |
		deco := self secondarySelectionElementClass new
			        listElement: aListElement;
			        nodes: d nodes;
			        yourself.
		aListElement addChild: deco ]
]

{ #category : #'api - accessing' }
ToListElementContextMenuSelectionEventHandler >> eventsToHandle [

	^ {
		  ToListSelectionChangedEvent.
		  ToListElementContextMenuRequest.
		  ToContextMenuClosedEvent.
		  ToListElementContextMenuSelectionChangedEvent }
]

{ #category : #'element handlers' }
ToListElementContextMenuSelectionEventHandler >> listElementContextMenuRequest: anEvent [

	| childNode target infinite globalPosition |
	target := anEvent currentTarget.
	infinite := target infinite.
	target disableScrolledEvent.
	globalPosition := anEvent sourceEvent position.
	childNode := infinite children
		             detect: [ :node |
		             node containsGlobalPoint: globalPosition ]
		             ifNone: [  ].
	childNode ifNil: [ ^ self ].
	childNode holder isSelected
		ifTrue: [
			anEvent selection selectAllIndexes:
				target selectionModel selectedIndexes ]
		ifFalse: [ anEvent selection selectIndex: childNode holder position ].

	target dispatchEvent:
		(ToListElementContextMenuSelectionChangedEvent new
			 node: childNode;
			 selection: anEvent selection;
			 sourceEvent: anEvent sourceEvent;
			 yourself)
]

{ #category : #'element handlers' }
ToListElementContextMenuSelectionEventHandler >> listElementContextMenuSelectionChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	
	anEvent selection isEmpty ifTrue: [
		self removeContextMenuSelectionIn: target.
		^ self ].

	anEvent node holder isSelected 
		ifTrue: [ self contextMenuSelectionOverPrimaryIn: target ]
		ifFalse: [
			self addContextMenuSelectionIn: target onNode: anEvent node ]
]

{ #category : #'element handlers' }
ToListElementContextMenuSelectionEventHandler >> listSelectionChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target currentContextMenu ifNotNil: [ :win |
		win isOpened ifTrue: [ win close ] ].
	self removeContextMenuSelectionIn: target
]

{ #category : #'selection managing' }
ToListElementContextMenuSelectionEventHandler >> removeContextMenuSelectionIn: aListElement [

	(aListElement allChildrenBreadthFirstSelect: [ :child |
		 child isKindOf: ToListContextMenuSelectionElement ]) do: [ :d |
		d removeFromParent ]
]

{ #category : #accessing }
ToListElementContextMenuSelectionEventHandler >> secondarySelectionElementClass [

	^ ToListContextMenuSelectionElement
]
