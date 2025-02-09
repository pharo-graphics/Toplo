Class {
	#name : #ToIconStyle,
	#superclass : #Object,
	#category : #'Toplo-Core-Theme'
}

{ #category : #'instance creation' }
ToIconStyle class >> filled [

	^ ToIconFilledStyle new
]

{ #category : #accessing }
ToIconStyle class >> iconNamed: anIconName inProvider: anIconProvider [

	^ anIconProvider iconNamed:
		  (self prefix , '_', anIconName) asSymbol
]

{ #category : #accessing }
ToIconStyle class >> innerImageNamed: anIconName inProvider: anIconProvider [

	^ anIconProvider innerImageNamed:
		  (self prefix , '_', anIconName) asSymbol
]

{ #category : #'instance creation' }
ToIconStyle class >> outlined [

	^ ToIconOutlinedStyle new
]

{ #category : #accessing }
ToIconStyle class >> prefix [

	^ self subclassResponsibility 
]

{ #category : #'instance creation' }
ToIconStyle class >> twotone [

	^ ToIconTwotoneStyle new
]

{ #category : #accessing }
ToIconStyle >> iconNamed: anIconName inProvider: anIconProvider [ 
	^ self class iconNamed: anIconName inProvider: anIconProvider 
]

{ #category : #accessing }
ToIconStyle >> innerImageNamed: anIconName inProvider: anIconProvider [ 
	^ self class innerImageNamed: anIconName inProvider: anIconProvider 
]

{ #category : #accessing }
ToIconStyle >> prefix [

	^ self class prefix
]
