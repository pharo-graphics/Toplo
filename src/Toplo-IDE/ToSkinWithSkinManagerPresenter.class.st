Class {
	#name : #ToSkinWithSkinManagerPresenter,
	#superclass : #ToSkinPresenter,
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #layout }
ToSkinWithSkinManagerPresenter >> defaultLayout [

	^ SpBoxLayout new
		  add: (SpLabelPresenter new
				   label: 'I have a skin';
				   yourself);
		  yourself
]
