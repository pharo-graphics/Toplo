Class {
	#name : #ToMenuItemNode,
	#superclass : #ToItemNode,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #initialization }
ToMenuItemNode >> defaultLayout [ 

	" Notice that the use vertical forbid vertical centering of children "
	^ BlLinearLayout vertical
]
