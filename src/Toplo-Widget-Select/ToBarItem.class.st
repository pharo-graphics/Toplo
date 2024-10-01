Class {
	#name : #ToBarItem,
	#superclass : #ToAbstractBarItem,
	#instVars : [
		'index',
		'pickOrder'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'instance creation' }
ToBarItem class >> index: anIndex [

	^ self new index: anIndex; yourself
]

{ #category : #'node building' }
ToBarItem >> buildNode: aNode inHolder: aNodeHolder withManager: aNodeManager [

	| data |
	data := aNodeHolder dataAccessor at: index.
	aNodeManager nodeBuilder value: aNode value: data value: aNodeHolder.
	aNode addEventHandlerOn: ToInnerElementRemovedEvent do: [ :event |
		event consume.
		aNode removeFromBar ]
]

{ #category : #accessing }
ToBarItem >> index [

	^ index
]

{ #category : #accessing }
ToBarItem >> index: anInteger [

	index := anInteger
]

{ #category : #accessing }
ToBarItem >> indexes [

	^ Array with: index
]

{ #category : #accessing }
ToBarItem >> items [

	^ { self }
]

{ #category : #accessing }
ToBarItem >> nodesCount [

	^ 1
]

{ #category : #accessing }
ToBarItem >> pickOrder [

	^ pickOrder
]

{ #category : #accessing }
ToBarItem >> pickOrder: anInteger [

	pickOrder := anInteger
]
