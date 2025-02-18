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
ToMenuScrollableBarTrackElement >> newFlowLayoutIn: aBarElement [

	^ (super newFlowLayoutIn: aBarElement)
		  menuBarOwner: aBarElement menuBarOwner;
		  yourself
]
