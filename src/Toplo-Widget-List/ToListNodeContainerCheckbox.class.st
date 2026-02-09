Class {
	#name : #ToListNodeContainerCheckbox,
	#superclass : #ToCheckbox,
	#instVars : [
		'nodeContainer'
	],
	#category : #'Toplo-Widget-List-Node'
}

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
