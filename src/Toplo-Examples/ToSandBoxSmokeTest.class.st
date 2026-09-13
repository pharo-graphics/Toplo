Class {
	#name : #ToSandBoxSmokeTest,
	#superclass : #ToExamplesSmokeTest,
	#category : #'Toplo-Examples-SandBox'
}

{ #category : #accessing }
ToSandBoxSmokeTest class >> ignoredExampleSelectors [

	^ #(
		#example_AnchorWithPointTransition
		#example_PicsumPhotosGallery
		#example_PicsumPhotosGallery_crashing
		#example_listWithAllClasses
		#example_toImageFromUrl
		#example_toImageFromUrl2
		)
]

{ #category : #accessing }
ToSandBoxSmokeTest class >> targetClass [

	^ ToSandBox
]
