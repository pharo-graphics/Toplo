Class {
	#name : #ToSpaceThemeViewerSpec,
	#superclass : #SpPresenter,
	#instVars : [
		'space',
		'elementsTree'
	],
	#category : #'Toplo-IDE'
}

{ #category : #layout }
ToSpaceThemeViewerSpec >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  first: (ToLabelPresenter new
				   label: 'An error occured';
				   yourself);
		  second: 
				   self elementsTree;
				    yourself
]

{ #category : #accessing }
ToSpaceThemeViewerSpec >> elementsTree [

	^ elementsTree
]

{ #category : #initialization }
ToSpaceThemeViewerSpec >> initializePresenters [

	elementsTree := SpTreePresenter new
		                children: [ :element | element children ];
		                display: [ :element | element printString ];
		                whenSelectedItemChangedDo: [ :element |
			                self updateSkin: element ];
		                yourself.
]

{ #category : #accessing }
ToSpaceThemeViewerSpec >> space [

	^ space
]

{ #category : #accessing }
ToSpaceThemeViewerSpec >> space: anObject [

	space := anObject.
	self elementsTree roots: { space root }.
	space root addEventHandlerOn: ToThemeChangedEvent do: [
		self layout first:
			(space userData at: #toTheme) inspectionThemeWithSkin.
			self updateSkin: self elementsTree selectedItem ].
	self layout first:
		(space userData at: #toTheme) inspectionThemeWithSkin
]

{ #category : #initialization }
ToSpaceThemeViewerSpec >> updateSkin: aBlElement [

	self layout children first blElement: aBlElement.

]
