Class {
	#name : #ToListNodeContainerCheckbox,
	#superclass : #ToCheckbox,
	#instVars : [
		'nodeContainer'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #initialization }
ToListNodeContainerCheckbox >> initialize [ 

	super initialize.
	self id: #'list-selection-checkbox'.
	" the checkbox is not responsible for its skin update (to render the check state).
	The update is done by the list element primary selection event handler 
	as a consequence of the primary selection change "
	self switchToNextCheckStateOnClick: false.
	self focusability: BlFocusability none.

]

{ #category : #skin }
ToListNodeContainerCheckbox >> newRawSkin [ 

	^ ToListNodeContainerCheckboxSkin new
]

{ #category : #accessing }
ToListNodeContainerCheckbox >> nodeContainer [

	^ nodeContainer
]

{ #category : #accessing }
ToListNodeContainerCheckbox >> nodeContainer: aNodeContainer [

	nodeContainer := aNodeContainer
]
