Class {
	#name : #ToSelectHeaderElement,
	#superclass : #ToElementBar,
	#instVars : [
		'filtrable',
		'windowManager'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToSelectHeaderElement >> filterString [ 

	^ headerNodeContainer filterString
]

{ #category : #accessing }
ToSelectHeaderElement >> filtrable: aBoolean [

	filtrable := aBoolean
]

{ #category : #initialization }
ToSelectHeaderElement >> initialize [

	super initialize.
	filtrable := true.
	nodeWrapping := true.

	self id: #headerElement
]

{ #category : #testing }
ToSelectHeaderElement >> isFiltrable [ 

	^ filtrable
]

{ #category : #'instance creation' }
ToSelectHeaderElement >> newHeaderNodeContainer [

	^ super newHeaderNodeContainer
		  id: #headerNodeContainer;
		  yourself
]

{ #category : #window }
ToSelectHeaderElement >> onWindowClosed [

	self headerNodeContainer onWindowClosed
]

{ #category : #window }
ToSelectHeaderElement >> onWindowOpened [

	self headerNodeContainer onWindowOpened
]

{ #category : #accessing }
ToSelectHeaderElement >> pattern [

	self sieve pattern
]

{ #category : #accessing }
ToSelectHeaderElement >> sieve [

	^ windowManager sieve
]

{ #category : #accessing }
ToSelectHeaderElement >> textInputElement [ 

	^ headerNodeContainer textInputElement
]

{ #category : #accessing }
ToSelectHeaderElement >> windowManager [

	^ windowManager
]

{ #category : #accessing }
ToSelectHeaderElement >> windowManager: aSelectWindowManager [

	windowManager := aSelectWindowManager 
]
