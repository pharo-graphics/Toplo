Class {
	#name : #ToImportedIconProvider,
	#superclass : #ToIconProvider,
	#category : #'Toplo-Core-Theme'
}

{ #category : #'loaded and unloadable' }
ToImportedIconProvider class >> _loaded [

	^ #(  )
]

{ #category : #'loaded and unloadable' }
ToImportedIconProvider class >> _unloadable [

	^ #(  )
]

{ #category : #accessing }
ToImportedIconProvider class >> iconNamed: aName [

	| aToImportedIconProvider |
	aToImportedIconProvider := self new.

	^ aToImportedIconProvider iconNamed: aName ifAbsent: [  ]
]

{ #category : #accessing }
ToImportedIconProvider class >> iconNamed: aName ifAbsent: aBlock [

	| aToImportedIconProvider |
	aToImportedIconProvider := self new.

	^ [
	  ToImage inner:
		  (aToImportedIconProvider class perform: aName asSymbol) ]
		  on: Error
		  do: [ :err | aBlock value ]
]

{ #category : #accessing }
ToImportedIconProvider >> iconNamed: aName [ 
	^ self class iconNamed: aName 
]

{ #category : #accessing }
ToImportedIconProvider >> iconNamed: aName ifAbsent: aBlock [ 
	^ self class iconNamed: aName ifAbsent: aBlock 
]
