Class {
	#name : #ToWidget,
	#superclass : #BlElement,
	#category : #'Toplo-Widgets'
}

{ #category : #initialization }
ToWidget >> defaultBackground [
	^ Color transparent
]

{ #category : #accessing }
ToWidget >> viewModel [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToWidget >> viewModel: aViewModel [

	^ self subclassResponsibility 
]
