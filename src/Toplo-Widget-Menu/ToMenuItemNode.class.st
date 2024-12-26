Class {
	#name : #ToMenuItemNode,
	#superclass : #ToItemNode,
	#category : #'Toplo-Widget-Menu-ItemList'
}

{ #category : #initialization }
ToMenuItemNode >> defaultLayout [ 

	" Notice that the use vertical forbid vertical centering of children "
	^ BlLinearLayout vertical
]
