Class {
	#name : #ToLabelLineMode,
	#superclass : #Object,
	#category : #'Toplo-Widget-Label'
}

{ #category : #adding }
ToLabelLineMode >> addEditorIn: aLabel [

	^ self subclassResponsibility  
]

{ #category : #initialization }
ToLabelLineMode >> newTextElement [

	^ self subclassResponsibility 
	
]
