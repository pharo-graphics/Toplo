Class {
	#name : #ToMultipleNodeBar,
	#superclass : #ToElementBar,
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #initialization }
ToMultipleNodeBar >> initialize [ 

	super initialize.
	self installNodeContainer
]

{ #category : #accessing }
ToMultipleNodeBar >> multipleSelection: aBoolean [

	Error signal: 'Can''t change the selection mode, only multiple selection is possible'
]

{ #category : #initialization }
ToMultipleNodeBar >> multipleSelectionByDefault [ 

	^ true
]

{ #category : #'instance creation' }
ToMultipleNodeBar >> newMultipleSelectionNodeContainer [

	^  ToMultipleNodeBarContainerElement new
]

{ #category : #'instance creation' }
ToMultipleNodeBar >> newSingleSelectionNodeContainer [

	self shouldNotImplement 
]
