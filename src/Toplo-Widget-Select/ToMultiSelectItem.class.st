Class {
	#name : #ToMultiSelectItem,
	#superclass : #ToAbstractMultiSelectDataItem,
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

{ #category : #accessing }
ToMultiSelectItem >> index [

	^ index
]

{ #category : #accessing }
ToMultiSelectItem >> index: anInteger [

	index := anInteger
]

{ #category : #accessing }
ToMultiSelectItem >> indexes [

	^ Array with: index
]

{ #category : #accessing }
ToMultiSelectItem >> items [

	^ { self }
]

{ #category : #accessing }
ToMultiSelectItem >> nodesCount [

	^ 1
]

{ #category : #accessing }
ToMultiSelectItem >> pickOrder [

	^ pickOrder
]

{ #category : #accessing }
ToMultiSelectItem >> pickOrder: anInteger [

	pickOrder := anInteger
]
