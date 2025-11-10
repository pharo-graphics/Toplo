"
I represent how header should be render. The disposition should be similar to what List have (for the size of the columns)
"
Class {
	#name : #ToTableHeaderElement,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #initialization }
ToTableHeaderElement class >> initializeToRawTheme: aTheme [

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme
		addTokenNamed: #'table-label-weight-attribute'
		withValue: BlFontWeightAttribute bold.

	" Now setup the default label weight and the header padding "
	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme when: ToInstallSkinEvent do: [ :header |
					header
						addTokenNamed: #'font-weight-attribute'
						withValue:
						(header valueOfTokenNamed: #'table-label-weight-attribute').
					header padding: (BlInsets
							 horizontal: (header valueOfTokenNamed: #'list-padding-H')
							 vertical: (header valueOfTokenNamed: #'list-padding-V')) ] ]
]

{ #category : #accessing }
ToTableHeaderElement >> columns: aListOfColumns [
	self removeChildren.
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
