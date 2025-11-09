"
I represent how header should be render. The disposition should be similar to what List have (for the size of the columns)
"
Class {
	#name : #ToTableHeaderElement,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #accessing }
ToTableHeaderElement >> columns: aListOfColumns [

	aListOfColumns do: [ :column |
			self addChild: ((ToLabel text: column title)
					 matchParent;
					 yourself) ]
]

{ #category : #initialization }
ToTableHeaderElement >> defaultLayout [ 

	" don't use vertical or horizontal to allow vertical centering of children "
	^ BlLinearLayout new
]

{ #category : #initialization }
ToTableHeaderElement >> initialize [

	super initialize.
	self constraints vertical fitContent.
	self constraints horizontal matchParent.
]
