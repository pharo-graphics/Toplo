Class {
	#name : #ToMultiSelectDataItem,
	#superclass : #ToAbstractMultiSelectDataItem,
	#instVars : [
		'index'
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
ToMultiSelectDataItem >> nodesCount [

	^ 1
]
