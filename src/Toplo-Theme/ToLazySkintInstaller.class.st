Class {
	#name : #ToLazySkintInstaller,
	#superclass : #ToAbstractSkinInstaller,
	#category : #'Toplo-Theme-Core'
}

{ #category : #accessing }
ToLazySkintInstaller >> defaultSkinIn: anElement [

	^ anElement defaultSkin
]
