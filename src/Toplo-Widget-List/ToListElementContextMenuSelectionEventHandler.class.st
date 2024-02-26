Class {
	#name : #ToListElementContextMenuSelectionEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'selection managing' }
ToListElementContextMenuSelectionEventHandler >> addContextMenuSelectionIn: aListElement onNode: aChildNode [
	" update selection decoration to show the secondary selection on which the popup is opened"

	| deco |
	deco := ToListContextMenuSelectionElement new
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

	| adjacentNodeGroups |
	adjacentNodeGroups := aListElement infinite nodeGroupsSatisfying: [
		                      :n | n holder isSelected ].
	adjacentNodeGroups do: [ :group |
		| deco |
		deco := ToListContextMenuSelectionElement new
			        listElement: aListElement;
			        nodes: group;
			        yourself.
		aListElement addChild: deco ]
]

{ #category : #'api - accessing' }
ToListElementContextMenuSelectionEventHandler >> eventsToHandle [

	^ {
		  ToListPrimarySelectionChangedEvent.
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
			anEvent selection selectIndexes:
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
		target contextMenuSelectionElements  do: [ :s | s removeFromParent ].
		^ self ].

	anEvent node holder isSelected 
		ifTrue: [ self contextMenuSelectionOverPrimaryIn: target ]
		ifFalse: [
			self addContextMenuSelectionIn: target onNode: anEvent node ]
]

{ #category : #'element handlers' }
ToListElementContextMenuSelectionEventHandler >> listPrimarySelectionChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target currentContextMenu ifNotNil: [ :win |
		win isOpened ifTrue: [ win close ] ].
	target contextMenuSelectionElements do: [ :d |
		d removeFromParent ]
]
