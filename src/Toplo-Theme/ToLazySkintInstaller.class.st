Class {
	#name : 'ToLazySkintInstaller',
	#superclass : 'ToAbstractSkinInstaller',
	#category : 'Toplo-Theme-Core',
	#package : 'Toplo-Theme',
	#tag : 'Core'
}

{ #category : 'accessing' }
ToLazySkintInstaller >> defaultSkinIn: anElement [

	^ anElement defaultSkin
]
