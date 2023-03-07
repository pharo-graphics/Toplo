"
I'm a container for columns in the process of being shown in container. 
I have display column properties (that might or might not be in column it self).

Originally I'm used to send data outside container that might be used (for example, resizing).
"
Class {
	#name : #ToFTDisplayColumn,
	#superclass : #Object,
	#instVars : [
		'column',
		'width'
	],
	#category : #'Toplo-FastTable-Base'
}

{ #category : #'instance creation' }
ToFTDisplayColumn class >> column: aColumn width: aWidth [
	^ self new
		column: aColumn;
		width: aWidth;
		yourself
]

{ #category : #accessing }
ToFTDisplayColumn >> column [
	^ column
]

{ #category : #accessing }
ToFTDisplayColumn >> column: anObject [
	column := anObject
]

{ #category : #accessing }
ToFTDisplayColumn >> width [
	^ width
]

{ #category : #accessing }
ToFTDisplayColumn >> width: anObject [
	width := anObject
]
