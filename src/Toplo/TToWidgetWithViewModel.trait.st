Trait {
	#name : #TToWidgetWithViewModel,
	#category : 'Toplo-Core'
}

{ #category : #'t - widget with  view model - accessing' }
TToWidgetWithViewModel >> viewModel [

	" should be lazy to avoid unecessary instanciation and installation "
	^ self userData at: #viewModel ifAbsent: [  ]
]

{ #category : #'t - widget with  view model - accessing' }
TToWidgetWithViewModel >> viewModel: aViewModel [

	" A viewModel is normally installed only once by the widget or by the viewModel itself.
	Installing a new viewModel is possible but be aware of what you are doing (lost of data stored in the installed viewModel)."
	self viewModelDo: [ :aCurrentModel | aCurrentModel launchUninstallationIn: self ].
	self userData at: #viewModel put: aViewModel.
	self viewModelDo: [ :aCurrentModel | aViewModel launchInstallationIn: self ]
]

{ #category : #'t - widget with  view model - accessing' }
TToWidgetWithViewModel >> viewModelDo: aBlock [

	self viewModel ifNotNil: [ :vm | aBlock cull: vm ]
]
