import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { RecoilRoot } from 'recoil';
import AppNavigator from './AppNavigator';

const queryClient = new QueryClient();

export default function App() {
    return (
        <QueryClientProvider client={queryClient}>
            <RecoilRoot>
                <AppNavigator />
            </RecoilRoot>
        </QueryClientProvider>
    );
}
