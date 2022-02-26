Class {
	#name : #ToWidget,
	#superclass : #BlElement,
	#category : #'Toplo-Widgets'
}

{ #category : #initialization }
ToWidget >> defaultOutskirts [
	^ BlOutskirts outside
]

{ #category : #accessing }
ToWidget >> model [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToWidget >> model: anObject [

	
]
