Class {
	#name : #ToMenuScrollableBarTrackElement,
	#superclass : #ToScrollableBarTrackElement,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #layout }
ToMenuScrollableBarTrackElement >> flowLayoutClass [

	^ ToMenuBarFlowLayout 
]

{ #category : #layout }
ToMenuScrollableBarTrackElement >> newFlowLayout [

	^ (super newFlowLayout)
		  menuBarOwner: listElement menuBarOwner;
		  yourself
]
