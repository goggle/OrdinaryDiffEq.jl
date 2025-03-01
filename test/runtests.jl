using Pkg
using SafeTestsets, Test
const LONGER_TESTS = false

const GROUP = get(ENV, "GROUP", "All")
const is_APPVEYOR = Sys.iswindows() && haskey(ENV, "APPVEYOR")

function activate_downstream_env()
    Pkg.activate("downstream")
    Pkg.develop(PackageSpec(path = dirname(@__DIR__)))
    Pkg.instantiate()
end

#Start Test Script

@time begin
    if GROUP == "All" || GROUP == "InterfaceI" || GROUP == "Interface"
        @time @safetestset "Discrete Algorithm Tests" include("interface/discrete_algorithm_test.jl")
        @time @safetestset "Tstops Tests" include("interface/ode_tstops_tests.jl")
        @time @safetestset "Backwards Tests" include("interface/ode_backwards_test.jl")
        @time @safetestset "Initdt Tests" include("interface/ode_initdt_tests.jl")
        @time @safetestset "Linear Tests" include("interface/ode_twodimlinear_tests.jl")
        @time @safetestset "Differentiation Trait Tests" include("interface/differentiation_traits_tests.jl")
        @time @safetestset "Inf Tests" include("interface/inf_handling.jl")
        @time @safetestset "Jacobian Tests" include("interface/jacobian_tests.jl")
        @time @safetestset "saveat Tests" include("interface/ode_saveat_tests.jl")
        @time @safetestset "save_idxs Tests" include("interface/ode_saveidxs_tests.jl")
        @time @safetestset "Scalar Handling Tests" include("interface/scalar_handling_tests.jl")
        @time @safetestset "Static Array Tests" include("interface/static_array_tests.jl")
        @time @safetestset "u_modified Tests" include("interface/umodified_test.jl")
        @time @safetestset "Composite Algorithm Tests" include("interface/composite_algorithm_test.jl")
        @time @safetestset "Complex Tests" include("interface/complex_tests.jl")
        @time @safetestset "Ndim Complex Tests" include("interface/ode_ndim_complex_tests.jl")
        @time @safetestset "Number Type Tests" include("interface/ode_numbertype_tests.jl")
        @time @safetestset "Stiffness Detection Tests" include("interface/stiffness_detection_test.jl")
        @time @safetestset "Composite Interpolation Tests" include("interface/composite_interpolation.jl")
        @time @safetestset "Export tests" include("interface/export_tests.jl")
        @time @safetestset "Type Handling Tests" include("interface/type_handling.jl")
        @time @safetestset "Controller Tests" include("interface/controllers.jl")
        @time @safetestset "Inplace Interpolation Tests" include("interface/inplace_interpolation.jl")
    end

    if !is_APPVEYOR && (GROUP == "All" || GROUP == "InterfaceII" || GROUP == "Interface")
        #@time @safetestset "No Recompile Tests" include("interface/norecompile.jl") # doesn't work on CI?
        @time @safetestset "Linear Nonlinear Solver Tests" include("interface/linear_nonlinear_tests.jl")
        @time @safetestset "Linear Solver Tests" include("interface/linear_solver_test.jl")
        @time @safetestset "Linear Solver Split ODE Tests" include("interface/linear_solver_split_ode_test.jl")
        @time @safetestset "Sparse Diff Tests" include("interface/sparsediff_tests.jl")
        @time @safetestset "Enum Tests" include("interface/enums.jl")
        @time @safetestset "Mass Matrix Tests" include("interface/mass_matrix_tests.jl")
        @time @safetestset "W-Operator prototype tests" include("interface/wprototype_tests.jl")
    end

    if !is_APPVEYOR && (GROUP == "All" || GROUP == "InterfaceIII" || GROUP == "Interface")
        @time @safetestset "Derivative Utilities Tests" include("interface/utility_tests.jl")
        @time @safetestset "stats Tests" include("interface/stats_tests.jl")
        @time @safetestset "No Index Tests" include("interface/noindex_tests.jl")
        @time @safetestset "Events + DAE addsteps Tests" include("interface/event_dae_addsteps.jl")
        @time @safetestset "No Jac Tests" include("interface/nojac.jl")
        @time @safetestset "Preconditioner Tests" include("interface/preconditioners.jl")
        @time @safetestset "Units Tests" include("interface/units_tests.jl")
        @time @safetestset "Non-Full Diagonal Sparsity Tests" include("interface/nonfulldiagonal_sparse.jl")
    end

    if !is_APPVEYOR && (GROUP == "All" || GROUP == "InterfaceIV" || GROUP == "Interface")
        @time @safetestset "Autodiff Error Tests" include("interface/autodiff_error_tests.jl")
        @time @safetestset "Ambiguity Tests" include("interface/ambiguity_tests.jl")
        @time @safetestset "Sized Matrix Tests" include("interface/sized_matrix_tests.jl")
        @time @safetestset "Second Order with First Order Solver Tests" include("interface/second_order_with_first_order_solvers.jl")
    end

    if !is_APPVEYOR && (GROUP == "All" || GROUP == "InterfaceV" || GROUP == "Interface")
        @time @safetestset "AD Tests" include("interface/ad_tests.jl")
        @time @safetestset "Newton Tests" include("interface/newton_tests.jl")
        @time @safetestset "DAE Initialize Integration" include("interface/dae_initialize_integration.jl")
    end

    if !is_APPVEYOR &&
       (GROUP == "All" || GROUP == "Integrators_I" || GROUP == "Integrators")
        @time @safetestset "Reinit Tests" include("integrators/reinit_test.jl")
        @time @safetestset "Events Tests" include("integrators/ode_event_tests.jl")
        @time @safetestset "Alg Events Tests" include("integrators/alg_events_tests.jl")
        @time @safetestset "Discrete Callback Dual Tests" include("integrators/discrete_callback_dual_test.jl")
        @time VERSION >= v"1.9" && @safetestset "Callback Allocation Tests" include("integrators/callback_allocation_tests.jl")
        @time @safetestset "Iterator Tests" include("integrators/iterator_tests.jl")
        @time @safetestset "Integrator Interface Tests" include("integrators/integrator_interface_tests.jl")
        @time @safetestset "Error Check Tests" include("integrators/check_error.jl")
        @time @safetestset "Event Detection Tests" include("integrators/event_detection_tests.jl")
        @time @safetestset "Event Repetition Detection Tests" include("integrators/event_repeat_tests.jl")
    end

    if !is_APPVEYOR &&
       (GROUP == "All" || GROUP == "Integrators_II" || GROUP == "Integrators")
        @time @safetestset "Reverse Directioned Event Tests" include("integrators/rev_events_tests.jl")
        @time @safetestset "Differentiation Direction Tests" include("integrators/diffdir_tests.jl")
        @time @safetestset "Resize Tests" include("integrators/resize_tests.jl")
        @time @safetestset "DAE Initialization Tests" include("integrators/dae_initialization_tests.jl")
        @time @safetestset "DAE Event Tests" include("integrators/dae_event.jl")
        @time @safetestset "Cache Tests" include("integrators/ode_cache_tests.jl")
        @time @safetestset "Add Steps Tests" include("integrators/ode_add_steps_tests.jl")
        @time @safetestset "IMEX Split Function Tests" include("integrators/split_ode_tests.jl")
    end

    if !is_APPVEYOR && (GROUP == "All" || GROUP == "Regression_I" || GROUP == "Regression")
        @time @safetestset "Dense Tests" include("regression/ode_dense_tests.jl")
        @time @safetestset "Special Interp Tests" include("regression/special_interps.jl")
        @time @safetestset "Inplace Tests" include("regression/ode_inplace_tests.jl")
        @time @safetestset "Adaptive Tests" include("regression/ode_adaptive_tests.jl")
        @time @safetestset "Hard DAE Tests" include("regression/hard_dae.jl")
    end

    if !is_APPVEYOR && (GROUP == "All" || GROUP == "Regression_II" || GROUP == "Regression")
        @time @safetestset "PSOS Energy Conservation Tests" include("regression/psos_and_energy_conservation.jl")
        @time @safetestset "Unrolled Tests" include("regression/ode_unrolled_comparison_tests.jl")
        @time @safetestset "Time derivative Tests" include("regression/time_derivative_test.jl")
        @time @safetestset "IIP vs OOP Tests" include("regression/iipvsoop_tests.jl")
        @time @safetestset "Inference Tests" include("regression/inference.jl")
    end

    if !is_APPVEYOR && GROUP == "AlgConvergence_I"
        @time @safetestset "Partitioned Methods Tests" include("algconvergence/partitioned_methods_tests.jl")
        @time @safetestset "Convergence Tests" include("algconvergence/ode_convergence_tests.jl")
        @time @safetestset "DAE Convergence Tests" include("algconvergence/dae_convergence_tests.jl")
        @time @safetestset "Non-autonomous Convergence Tests" include("algconvergence/non-autonomous_convergence_tests.jl")
        @time @safetestset "Adams Variable Coefficients Tests" include("algconvergence/adams_tests.jl")
        @time @safetestset "Nordsieck Tests" include("algconvergence/nordsieck_tests.jl")
    end

    if !is_APPVEYOR && GROUP == "AlgConvergence_II"
        @time @safetestset "SSPRK Tests" include("algconvergence/ode_ssprk_tests.jl")
        @time @safetestset "Low Storage RK Tests" include("algconvergence/ode_low_storage_rk_tests.jl")
        @time @safetestset "OwrenZen Tests" include("algconvergence/owrenzen_tests.jl")
        @time @safetestset "Runge-Kutta-Chebyshev Tests" include("algconvergence/rkc_tests.jl")
    end

    if !is_APPVEYOR && GROUP == "AlgConvergence_III"
        @time @safetestset "Linear Methods Tests" include("algconvergence/linear_method_tests.jl")
        @time @safetestset "Split Methods Tests" include("algconvergence/split_methods_tests.jl")
        @time @safetestset "Rosenbrock Tests" include("algconvergence/ode_rosenbrock_tests.jl")
        @time @safetestset "FIRK Tests" include("algconvergence/ode_firk_tests.jl")
        @time @safetestset "Linear-Nonlinear Methods Tests" include("algconvergence/linear_nonlinear_convergence_tests.jl")
        @time @safetestset "Linear-Nonlinear Krylov Methods Tests" include("algconvergence/linear_nonlinear_krylov_tests.jl")
        @time @safetestset "Feagin Tests" include("algconvergence/ode_feagin_tests.jl")
        @time @safetestset "Extrapolation Tests" include("algconvergence/ode_extrapolation_tests.jl")
        @time @safetestset "Symplectic Tests" include("algconvergence/symplectic_tests.jl")
    end

    if !is_APPVEYOR && GROUP == "Downstream"
        activate_downstream_env()
        @time @safetestset "DelayDiffEq Tests" include("downstream/delaydiffeq.jl")
        @time VERSION >= v"1.9" && @safetestset "Autodiff Events Tests" include("downstream/autodiff_events.jl")
        @time @safetestset "Measurements Tests" include("downstream/measurements.jl")
    end

    if !is_APPVEYOR && GROUP == "ODEInterfaceRegression"
        activate_downstream_env()
        @time @safetestset "Init dt vs dorpri tests" include("odeinterface/init_dt_vs_dopri_tests.jl")
        @time @safetestset "ODEInterface Regression Tests" include("odeinterface/odeinterface_regression.jl")
    end

    if !is_APPVEYOR && GROUP == "Multithreading"
        @time @safetestset "Extrapolation Tests" include("multithreading/ode_extrapolation_tests.jl")
    end

    if !is_APPVEYOR && GROUP == "GPU"
        activate_downstream_env()
        @time @safetestset "Simple GPU" begin
            import OrdinaryDiffEq
            include(joinpath(dirname(pathof(OrdinaryDiffEq.DiffEqBase)), "..",
                "test/gpu/simple_gpu.jl"))
        end
        @time @safetestset "Autoswitch GPU" include("gpu/autoswitch.jl")
        @time @safetestset "Linear LSRK GPU" include("gpu/linear_lsrk.jl")
        @time @safetestset "Reaction-Diffusion Stiff Solver GPU" include("gpu/reaction_diffusion_stiff.jl")
    end
end # @time
