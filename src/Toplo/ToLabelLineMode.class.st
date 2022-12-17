Class {
	#name : #ToLabelLineMode,
	#superclass : #Object,
	#category : #'Toplo-Widget-Label'
}

{ #category : #testing }
ToLabelLineMode >> isMonoLine [ 

	^ false
]

{ #category : #testing }
ToLabelLineMode >> isMultiLine [ 

	^ false
]

{ #category : #initialization }
ToLabelLineMode >> newTextElementIn: aLabel [

	^ self subclassResponsibility 
	
]
