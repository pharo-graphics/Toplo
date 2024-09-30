Class {
	#name : #ToMultiSelectItem,
	#superclass : #ToAbstractMultiSelectItem,
	#instVars : [
		'index',
		'pickOrder'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'instance creation' }
ToMultiSelectItem class >> index: anIndex [

	^ self new index: anIndex; yourself
]

{ #category : #'node building' }
ToMultiSelectItem >> buildNode: aNode inHolder: aNodeHolder withManager: aNodeManager [

	| data |
	data := aNodeHolder dataAccessor at: index.
	aNodeManager nodeBuilder value: aNode value: data value: aNodeHolder.
	aNode addEventHandlerOn: ToInnerElementRemovedEvent do: [ :event |
		event consume.
		aNode removeFromBar ]
]

{ #category : #'as yet unclassified' }
ToMultiSelectItem >> index [

	^ index
]

{ #category : #'as yet unclassified' }
ToMultiSelectItem >> index: anInteger [

	index := anInteger
]

{ #category : #'as yet unclassified' }
ToMultiSelectItem >> indexes [

	^ Array with: index
]

{ #category : #'as yet unclassified' }
ToMultiSelectItem >> items [

	^ { self }
]

{ #category : #'as yet unclassified' }
ToMultiSelectItem >> nodesCount [

	^ 1
]

{ #category : #'as yet unclassified' }
ToMultiSelectItem >> pickOrder [

	^ pickOrder
]

{ #category : #'as yet unclassified' }
ToMultiSelectItem >> pickOrder: anInteger [

	pickOrder := anInteger
]
