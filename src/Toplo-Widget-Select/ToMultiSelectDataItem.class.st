Class {
	#name : #ToMultiSelectDataItem,
	#superclass : #ToAbstractMultiSelectDataItem,
	#instVars : [
		'index',
		'pickOrder'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'instance creation' }
ToMultiSelectDataItem class >> index: anIndex [

	^ self new index: anIndex; yourself
]

{ #category : #accessing }
ToMultiSelectDataItem >> index [

	^ index
]

{ #category : #accessing }
ToMultiSelectDataItem >> index: anInteger [

	index := anInteger
]

{ #category : #accessing }
ToMultiSelectDataItem >> indexes [

	^ Array with: index
]

{ #category : #accessing }
ToMultiSelectDataItem >> nodesCount [

	^ 1
]

{ #category : #accessing }
ToMultiSelectDataItem >> pickOrder [

	^ pickOrder
]

{ #category : #accessing }
ToMultiSelectDataItem >> pickOrder: anInteger [

	pickOrder := anInteger
]
