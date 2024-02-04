Class {
	#name : #ToListSelectionModel,
	#superclass : #ToSelectionModel,
	#instVars : [
		'currentIndex',
		'distance',
		'pivot'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #accessing }
ToListSelectionModel >> currentIndex [

	^ currentIndex
]

{ #category : #accessing }
ToListSelectionModel >> currentIndex: anIndex [

	currentIndex := anIndex
]

{ #category : #accessing }
ToListSelectionModel >> distance [

	^ distance
]

{ #category : #accessing }
ToListSelectionModel >> distance: anInteger [

	distance := anInteger
]

{ #category : #'instance creation' }
ToListSelectionModel >> newSelecter [

	^ ToListSelectionModelOperator new 
]

{ #category : #accessing }
ToListSelectionModel >> pivot [

	^ pivot
]

{ #category : #accessing }
ToListSelectionModel >> pivot: anInteger [

	pivot := anInteger
]
