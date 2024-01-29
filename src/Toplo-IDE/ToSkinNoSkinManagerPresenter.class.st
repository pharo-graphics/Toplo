Class {
	#name : #ToSkinNoSkinManagerPresenter,
	#superclass : #ToSkinPresenter,
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #layout }
ToSkinNoSkinManagerPresenter >> defaultLayout [

	^ SpBoxLayout new
		  add: (SpLabelPresenter new
				   label: 'I have no skin manager';
				   yourself);
		  yourself
]
